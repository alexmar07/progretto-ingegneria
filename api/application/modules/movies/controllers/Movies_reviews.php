<?php defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Controller per la lista utenti
 * 
 */
class Movies_reviews extends Core_Controller {
     
    public $module  = 'movies';
    public $model   = 'movie_review';

    public function add_post() {

        $post = $this->post();

        $this->validation->set_data($post);

        $this->validation->required([
            'title',
            'description',
            'valutation',
            'movie_id'
        ], 'Tutti i campi sono obbligatori');

        if ( ! $this->validation->is_valid()) {
            $this->response(json(FALSE, $this->validation->get_error_message()),200);
        }

        $post['user_id'] = $this->jwt->id;

        if ( $this->main_m->insert($post)) {
            $this->response(json(TRUE, 'La recensione è stata inserita'),200);
        }

        $this->response(json(FALSE, 'Errore durante l\'inserimento della recensione'),200);

    }
}