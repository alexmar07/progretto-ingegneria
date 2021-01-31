<?php defined('BASEPATH') OR exit('No direct script access allowed');

use Interfaces\NotificationInterface;
use phpDocumentor\Reflection\Types\This;

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
        $this->load->model($this->module.'/user_notifications_model', 'notification_m');
    }
    
    //------------------------------------------------------------------------------------------

    /**
     * Funzione per la registrazione dell'utente
     * 
     * @return json
     */
    public function register_post () {

        $post = $this->post();

        $this->validation->set_data($post);

        $this->validation->required(['first_name', 'last_name', 'email', 'password','username'], 'Tutti i campi sono obbligatori')
            ->email('email','L\'email non è valida')
            ->alphanum('username', 'L\'username deve essere composto da caratteri e numeri')
            ->minlen('password',8, 'La password deve essere almeno di 8 caratteri')
            ->callback([$this,'check_unique_email'], 'L\'email è gia stata utilizzata', $post)
            ->callback([$this,'check_unique_username'], 'L\'username è gia stato utilizzato', $post);

        if ( ! $this->validation->is_valid() ) {
            $this->response(json(FALSE, $this->validation->get_error_message()),200);
        }

        $user_id = $this->ion_auth->register($post['username'], $post['password'], $post['email'], [
            'first_name'    =>  $post['first_name'],
            'last_name'     =>  $post['last_name'],
            'newsletter'    =>  $post['newsletter']
        ]);

        if ( $user_id == false ) {
            $this->response(json(FALSE, 'Errore durante la registrazione'),200);
        }

        $this->response(json(TRUE, 'La registrazione è stata effettuata con successo'),200);

    }

    //------------------------------------------------------------------------------------------

    /**
     * Funziona che restituisce la lista degli utenti
     * 
     * @return json
     */
    public function list_get () {

        $get = $this->get();

        $search = []; 

        if ( isset($get['q']) ) {
            $search = $get['q'];
        }
        
        $users = $this->main_m->get_users($get['page'], $search);

        $this->response(json(TRUE, 'Lista utenti', $users));        
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
            $this->response(json(TRUE,'Invio notifica riuscito', ['notification_id'    =>  $notification_id]),200);
        }
        else {
            $this->response(json(FALSE,'Invio notifica fallito'),200);
        }

    }

    //------------------------------------------------------------------------------------------

    /**
     * Funzione che controlla la risposta dell'utente alla notifica.
     * Se accetta allora viene creato il collegamento,
     * altrimenti non succede nulla. 
     * In entrambi i casi la notifica viene cancellata.
     * 
     * @param int $notification_id Id della notifica
     * @return json
     * @access public
     */
    public function notifications_put($notification_id) {

        // Recupero l'azione 
        $action = $this->put('action');

        // Controllo se esiste l'azione
        if ( ! isset($action) || empty($action)) {
            $this->response(json(FALSE,'Non è stata scelta l\'azione'),200);
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
            $this->response(json(FALSE,'Errore durante l\'azione'),200);
        }
        else {

            // Committo le modifiche
            $this->db->trans_commit();
            
            // Invio la risposta di successo
            $this->response(json(TRUE,'Il collegamento è stato accettato'),200);

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
            $this->response(json(FALSE, 'Non ci sono notifiche'),200);
        }
        else {
            $this->response(json(TRUE,'Lista delle notifiche', [ 'notifications' => $notifications]),200);
        }

    }

    //------------------------------------------------------------------------------------------

    /**
     * Funziona per inviare la newsletter
     * 
     * @return json
     */
    public function send_newsletter_post() {

        $post = $this->post();

        $this->validation->set_data($post); 

        $this->validation->required(['subject','body'], 'Il campo è obbligatorio');

        if ( ! $this->validation->is_valid() ) {
            $this->response(json(FALSE, $this->validation->get_error_message()),200);
        }

        $this->load->library('email');

        $this->email->from('no-reply@cinemates.it', 'Cinemates');
        $this->email->subject($post['subject']);
        $this->email->message($post['body']);

        // Recupero tutti gli utenti iscritti alla newsletter
        $users = $this->main_m->gets(['newsletter' => 1]);

        if ( ! empty($users) ) {
            
            foreach($users as $u ) {
                $this->email->to($u->email)->send();
            }
        } 

        $this->response(json(TRUE, 'Le newsletter sono state inviate'),200);
        
    }

    //------------------------------------------------------------------------------------------

    /**
     * Funzione che controlla se esiste una sola email
     * 
     * @param array $data Dati inviati
     * @return bool
     */
    public function check_unique_email($data) {

        return $this->main_m->unique('email', $data['email']);
    } 

    //------------------------------------------------------------------------------------------
    
    /**
     * Funzione che controlla se esiste un solo username
     * 
     * @param array $data Dati inviati
     * @return bool
     */
    public function check_unique_username($data) {

        return $this->main_m->unique('username', $data['username']);
    }

    //------------------------------------------------------------------------------------------



}