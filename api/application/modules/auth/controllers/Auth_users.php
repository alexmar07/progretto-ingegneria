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
        $this->validation->required(['username','password'], 'I campi non possono essere vuoti');
        
        // Se la validazione non è andata a buon fine 
        // invio l'errore riscontrato
        if ( ! $this->validation->is_valid() ) {
            
            $this->response([
                'success'   =>  FALSE,
                'message'   =>  $this->validation->get_error_message()
            ],200);
        }
            
        // Provo ad eseguire il login
        if ( $this->ion_auth_m->login($data['username'], $data['password']) ) {

            // Se viene eseguito il login recupero i dati dell'utente
            $user = $this->user_m->get_by(['username' => $data['username']]);

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
            ], 200);
        }  
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
            ->callback([$this,'check_unique_email'], 'L\'email è gia stata utilizzata', $post['email'])
            ->callback([$this,'check_unique_username'], 'L\'username è gia stato utilizzato', $post['username']);

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
     * Funzione che controlla se esiste una sola email
     * 
     * @param array $data Dati inviati
     * @return bool
     */
    public function check_unique_email($email) {
        return $this->user_m->unique('email', $email);
    } 

    //------------------------------------------------------------------------------------------
    
    /**
     * Funzione che controlla se esiste un solo username
     * 
     * @param array $data Dati inviati
     * @return bool
     */
    public function check_unique_username($username) {
        return $this->user_m->unique('username', $username);
    }

    //------------------------------------------------------------------------------------------
}