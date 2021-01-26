<?php 

namespace Interfaces;

/**
 * Interfaccia per le notifiche
 * 
 */
interface NotificationInterface {

    /**
     * Costante con il valore in caso di accettazione della richiesta
     * 
     * @var string
     */
    const ACCEPT_REQUEST = 'accept_request';
    
    /**
     * Costante con il valore in caso di rifiuto della richiesta
     * 
     * @var string
     */
    const REJECT_REQUEST = 'reject_request';
}