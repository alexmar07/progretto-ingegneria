<?php defined('BASEPATH') OR exit('No direct script access allowed');

if ( ! function_exists('json')) {
    
    /**
     * Formatta la risposta per creare il json
     *
     * @param bool      $status     Stato della risposta
     * @param string    $message    Messaggio di risposta
     * @param array     $data       Dati da inviare al client
     * 
     * @return array
     */
	function json($status, $message, $data = []) {
        
        // Array di risposta con stato e messaggio
        $response = [
            'success'   =>  $status,
            'message'   =>  $message,
        ];

        // Se ci sono dati li aggiungo con la chiave 'data'
        if ( ! empty($data) ) {
            $response['data'] = $data;
        }

        return $response;
	}
}