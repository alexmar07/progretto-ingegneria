<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Test extends MX_Controller {

    private $faker;

    public function __construct() {
        parent::__construct();

        $this->faker = \Faker\Factory::create();
    }

    public function generate_users() {

        $this->load->library('ion_auth');

        for($i = 0; $i < 300; $i++ ) {

            $this->ion_auth->register($this->faker->unique()->userName, $this->faker->text(8), $this->faker->unique()->email,[
                'first_name' => $this->faker->firstName(),
                'last_name'  => $this->faker->lastName  
            ]);
            
        }
    }

}