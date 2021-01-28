<?php defined('BASEPATH') OR exit('No direct script access allowed');

use Interfaces\NotificationInterface;

/**
 * Controller per gli utenti
 * 
 */
class Users extends Core_Controller {

    public $module  = 'users';
    public $model   = 'user';
    
    //------------------------------------------------------------------------------------------

    /**
     * Costruttore.
     * 
     */
    public function __construct() {
        parent::__construct();    

        // Carico i modelli
        $this->load->model($this->module.'/user_to_user_model', 'user_to_user_m');
        $this->load->model($this->module.'/user_notifications', 'notification_m');
    }
    
    //------------------------------------------------------------------------------------------

    /**
     * Funzione per l'invio di una richiesta collegamento.
     *  
     * @return json
     * @access public
     */
    public function create_link_post () {

        // Recupero l'identificativo utente che ha fatto richiesta
        $user_to_link = $this->post('user_id'); 

        // Creo la notifica
        $data = [
            'user_send_id'      =>  $this->jwt->id,
            'user_receive_id'   =>  $user_to_link
        ];
        
        // Inserisco la notifica
        $notification_id = $this->notification_m->insert($data);

        // Se l'id inserito è diverso da 0 
        // allora l'inserimento è andato a buon fine
        // altrimenti è fallito
        if ( $notification_id != 0 ) {
            $this->response(json(TRUE,'Invio notifica riuscito', ['notification_id'    =>  $notification_id]));
        }
        else {
            $this->response(json(FALSE,'Invio notifica fallito'));
        }

    }

    //------------------------------------------------------------------------------------------

    /**
     * Funzione che controlla la risposta dell'utente alla notifica.
     * Se accetta allora viene creato il collegamento,
     * altrimenti non succede nulla. 
     * In entrambi i casi la notifica viene cancellata.
     * 
     * @params int $notification_id Id della notifica
     * @return json
     * @access public
     */
    public function notifications_put($notification_id) {

        // Recupero l'azione 
        $action = $this->put('action');

        // Controllo se esiste l'azione
        if ( ! isset($action) || empty($action)) {
            $this->response(json(FALSE,'Non è stata scelta l\'azione'));
        } 

        // Starto la transizione
        $this->db->trans_begin(); 

        // Controllo se l'azione è di accettazione di richiesta
        if ( $action == NotificationInterface::ACCEPT_REQUEST ) {
            
            // Recupero i dati della notifica
            $notification = $this->notification_m->assign($notification_id)->get();

            // Inserisco l'associazione tra utenti
            $this->user_to_user_m->insert([
                'user_id_1'  =>  $notification->user_send_id,
                'user_id_2'  =>  $notification->user_receive_id
            ]);
        }

        // In entrambi i casi cancello la notifica
        $this->notification_m->delete();
        
        // Controllo se la transizione è andata a buon fine
        if ( $this->db->trans_status() === FALSE ) {

            // Errore durante la transazione, eseguo il rollback
            $this->db->trans_rollback();

            // Invio il messaggio di errore
            $this->response(json(FALSE,'Errore durante l\'azione'));
        }
        else {

            // Committo le modifiche
            $this->db->trans_commit();
            
            // Invio la risposta di successo
            $this->response(json(TRUE,'Il collegamento è stato accettato'));

        }

    }

    //------------------------------------------------------------------------------------------

    /**
     * Funzione restituisce le notifiche all'utente loggato
     * 
     * @return json
     */
    public function notifications_get() {

        // Recupero le notifiche di un utente
        $notifications = $this->notification_m->gets([
            'user_receive_id' => $this->jwt->id
        ]);

        // Controllo se le notifiche
        if ( empty($notifications) ) {
            $this->response(json(FALSE, 'Non ci sono notifiche'));
        }
        else {
            $this->response(json(TRUE,'Lista delle notifiche', [ 'notifications' => $notifications] ));
        }

    }

    //------------------------------------------------------------------------------------------



}