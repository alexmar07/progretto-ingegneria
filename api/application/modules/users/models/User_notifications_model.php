<?php defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Modello per gli utenti ad utenti
 * 
 */
class User_notifications_model extends MY_Model {

    // Nome della tabella
    protected $_table = 'users_notifications';
    protected $_table_alias = 'N';
    protected $for_page = 20;

    public function get_notifications_by_user($user_id, $page) {
        
        $this->db->select([
            'U.first_name',
            'U.last_name',
            'U.username',
        ]);

        $this->set_relation('users/user_model', 'U.id = N.user_send_id');
        
        $this->db->limit($this->for_page, $this->for_page * ($page > 0 ? $page - 1 : 0));
        
        return $this->gets(['user_receive_id' => $user_id ]);
    }

    public function get_by_user_id($user_id) {

        $this->db->select([
            'user_receive_id'
        ]);

        return $this->gets(['user_send_id' => $user_id]);
    }

}