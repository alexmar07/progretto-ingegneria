<?php defined('BASEPATH') OR exit('No direct script access allowed');

use chriskacerguis\RestServer\RestController;

class Welcome extends RestController {

	public function __construct() {
		parent::__construct();
	}

	
	public function test_get()
	{
		$this->response(['data' => ['hello'=> 'Ciao']]);
		// $this->load->view('welcome_message');
		// $this->response( [
		// 	'status' => false,
		// 	'message' => 'No such user found'
		// ], 404 );
	}
}
