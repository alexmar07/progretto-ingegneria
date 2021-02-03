<?php defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Modello per le recensione dei film 
 * 
 */
class Movie_review_model extends MY_Model {

    // Nome della tabella
    protected   $_table = 'reviews';
    protected   $_table_alias     = 'R';
    private     $for_page         = 20;

    public function get_reviews_by_movie($movie_id, $page) {

        $this->db->select([
            'R.id',
            'R.title',
            'R.description',
            'R.valutation',
            'U.username'
        ])
        ->order_by('id', 'desc')
        ->limit($this->for_page, $this->for_page * ($page > 0 ? $page - 1 : 0));

        $this->set_relation('users/user_model', 'U.id = R.id', 'U');

        return $this->gets(['R.movie_id' => $movie_id]);
    }
}