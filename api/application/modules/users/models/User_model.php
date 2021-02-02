<?php defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Modello per gli utenti
 * 
 */
class User_model extends MY_Model {

    // Nome della tabella
    protected   $_table           = 'users';
    protected   $_table_alias     = 'U';
    private     $for_page         = 20;

    public function get_users($page = 1, $search = '') {

        $this->db->select([
            'U.id',
            'U.first_name',
            'U.last_name',
            'U.username',
            'U.email'
        ]);

        if ( ! empty($search )) {

            $this->db->where([
                'MATCH(first_name,last_name,email) AGAINST ("'.$search.'")' => NULL
            ]);
        }
        
        $this->set_relation('users/user_to_group_model', 'U.id = UTG.user_id', 'UTG')
            ->set_relation('users/user_group_model','UTG.group_id = UG.id', 'UG');

        $this->db->limit($this->for_page, $this->for_page * ($page > 0 ? $page - 1 : 0));

        return $this->gets(['UG.name' => 'members']);

    }
}