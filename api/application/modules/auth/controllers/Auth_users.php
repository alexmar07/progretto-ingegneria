<?php defined('BASEPATH') OR exit('No direct script access allowed');

use chriskacerguis\RestServer\RestController;

/**
 * Autentificazione degli utenti
 * 
 * 
 */
class Auth_users extends RestController {

    //-------------------------------------------------------------

    /**
     * Costruttore. 
     * 
     */
	public function __construct() {
        
        parent::__construct();

        // Carico le librerie
        $this->load->model('ion_auth_model','ion_auth_m');
        $this->load->model('users/user_model','user_m');
        $this->load->library('ion_auth');
        $this->load->library('validation');
        

    }

    //-------------------------------------------------------------
    
    /**
     *  Funzione per il login degli utenti 
     * 
     * @return json
     */
	public function login_post() {

        // Recupero i dati in post
        $data = $this->post();

        // Validazione dei dati in input
        $this->validation->set_data($data);

        
        // Imposto la validazione
        $this->validation->required(['email','password'], 'I campi non possono essere vuoti');
        
        // Se la validazione non è andata a buon fine 
        // invio l'errore riscontrato
        if ( ! $this->validation->is_valid() ) {
            
            $this->response([
                'success'   =>  FALSE,
                'message'   =>  $this->validation->get_error_message()
            ],400);
        }
            
        // Provo ad eseguire il login
        if ( $this->ion_auth_m->login($data['email'], $data['password']) ) {

            // Se viene eseguito il login recupero i dati dell'utente
            $user = $this->user_m->get_by(['email' => $data['email']]);

            // Dati da inserire nel JWT
            $token = [
                'id'            =>  $user->id,
                'username'      =>  $user->username,
                'email'         =>  $user->email,
                'last_login'    =>  $user->last_login,
                'first_name'    =>  $user->first_name, 
                'last_name'     =>  $user->last_name, 
                'timestamp'     =>  time()
            ];

            $this->response([
                'success'   =>  TRUE,
                'message'   => 'Login effettuato con successo',
                'data'      =>  [
                    'jwt'   => AUTHORIZATION::generateToken($token)
                ]
            ],200);
        }
        else {
            
            $this->response([
                'success'   =>  FALSE,
                'message'   =>  'Utente e/o password errate'
            ], 400);
        }  
    }
}