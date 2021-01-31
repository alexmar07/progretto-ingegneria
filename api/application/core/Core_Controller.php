<?php defined('BASEPATH') OR exit('No direct script access allowed');

use chriskacerguis\RestServer\RestController;
use Interfaces\NotificationInterface;

/**
 * Modello per gli utenti
 * 
 */
class Core_Controller extends RestController {

    /**
     * Nome del modulo che sto utilizzando
     * 
     * @var string 
     * @access public
     */
    public $module;

    /**
     * Nome del modello principale
     * 
     * @var string
     * @access public
     */
    public $model;

    /**
     * Decodifica del JWT
     * 
     * @var object
     * @access public
     */
    public $jwt;

    //------------------------------------------------------------------------------------------

    /**
     * Costruttore
     * 
     */
    public function __construct() { 
        parent::__construct();

        // Carico le librerie assenziali
        $this->load->library('validation');

        // Carico il modello principale del modulo
        $this->load->model($this->module.'/'.$this->model.'_model', 'main_m');

        // Funzione che inizializza il controller
        $this->initialize();
    }

    //------------------------------------------------------------------------------------------

    /**
     * Funzione che inizializza alcuni dati del controller
     * 
     * @return void
     * @access private  
     */
    private function initialize() {

        // Imposto gli header per le API
        header('Access-Control-Allow-Origin: *');
        header("Access-Control-Allow-Headers: X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Request-Method, Authorization");
        header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");

        $method = $_SERVER['REQUEST_METHOD'];
        if ($method == "OPTIONS") {
            die();
        }

        // Assegno il JWT, se è falso allora il JWT non è autorizzato
        if ( ($this->jwt = $this->check_api_access()) == false ) {
            $this->response(json(FALSE,'Non sei autorizzato'),200);
        } 

    }
        
    //----------------------------------------------------------------------------------------------------

    /**
     * Controllo l'accesso all'api
     * 
     * @return object | bool
     */
    private function check_api_access () {

        // Variabile che indica se il token è valido o meno
        $decodedToken = FALSE;

        // Recupero l'header della richiesta
        $headers = $this->input->request_headers();

        // Controllo se esiste e non è vuoto il campo in cui è presente il token
        // In questo verifico la validità del token
        // Altrimenti invio un messaggio di errore 
        if (array_key_exists('Authorization', $headers) && !empty($headers['Authorization'])) {
            $decodedToken = AUTHORIZATION::validateTimestamp($headers['Authorization']);
        }
        else {
            $this->response(json(FALSE,['message' => 'JWT non valido']),200);
        }
        
        return $decodedToken;
        
    }
}