<?php defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Modello per le liste dei film 
 * 
 */
class Movie_list_model extends MY_Model {

    // Nome della tabella
    protected $_table = 'movies_list';

    public function exist($user_id, $movie_id, $type ){

        $n = $this->db->where([
            'movie_id'  => $movie_id,
            'user_id'   => $user_id,
            'type'      => $type
        ])->count_all_results($this->_table); 

        return $n > 0;
    }

}