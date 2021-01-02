<?php

/**
 * Classe per la migrazione del database
 * 
 */
class Migrate extends CI_Controller {

    public function index() {   
        
        $this->load->library('migration');
        
        if ($this->migration->current() === FALSE) {
                show_error($this->migration->error_string());
        }
        else {
            echo "Migrazione effettuata".PHP_EOL;
        }
    }
}