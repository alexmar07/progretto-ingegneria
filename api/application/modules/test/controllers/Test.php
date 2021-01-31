<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Test extends MX_Controller {

    public function generate_users() {

        $faker = \Faker\Factory::create();
        $this->load->library('ion_auth');

        for($i = 0; $i < 50; $i++ ) {

            $this->ion_auth->register($faker->unique()->userName, $faker->text(8), $faker->unique()->email,[
                'first_name' => $faker->firstName(),
                'last_name'  => $faker->lastName  
            ]);
            
        }

    }
}