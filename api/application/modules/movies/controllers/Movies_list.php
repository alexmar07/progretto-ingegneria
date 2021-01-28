<?php defined('BASEPATH') OR exit('No direct script access allowed');


use Tmdb\Client;
use Tmdb\Event\BeforeRequestEvent;
use Tmdb\Event\Listener\Request\AcceptJsonRequestListener;
use Tmdb\Event\Listener\Request\ApiTokenRequestListener;
use Tmdb\Event\Listener\Request\ContentTypeJsonRequestListener;
use Tmdb\Event\Listener\Request\UserAgentRequestListener;
use Tmdb\Event\Listener\RequestListener;
use Tmdb\Event\RequestEvent;
use Tmdb\Token\Api\ApiToken;
use Tmdb\Token\Api\BearerToken;

/**
 * Controller per la lista utenti
 * 
 */
class Movies_list extends Core_Controller {
     
    public $module  = 'movies';
    public $model   = 'movie_list';

    //------------------------------------------------------------------------------

    /**
     * Costruttore.
     * 
     */
    public function __construct() {
        parent::__construct();
    }

    //-----------------------------------------------------------------------------

    /**
     * Aggiungi ad un film alla lista dei preferiti/da vedere
     * da parte di un utente.
     * 
     * @return json
     */
    public function add_post() {

        // Recupero i dati in post
        $post = $this->post();

        // Inserisco il film alla lista
        $id = $this->main_m->insert([
            'user_id'   =>  $this->jwt->id,
            'movie_id'  =>  $post['movie_id'],
            'type'      =>  $post['type'] 
        ]);
        
        if ( $id != 0 ) {
            $this->response(json(TRUE,'Film aggiunto alla lista',['item_id' => $id]), 200);
        }

        $this->response(json(FALSE,'Errore durante l\'aggiunta del film'), 400);

    }

    //-----------------------------------------------------------------------------
    
    /**
     * Restituisce la lista dei film preferiti/da vedere
     * 
     * @return json
     */
    public function list_get () {

        $data = $this->main_m->gets([
            'user_id'   =>  $this->jwt->id,
            'type'      =>  $this->get('type')
        ]);

        $results = [];
        
        $status = FALSE;

        $client = $this->create_client();
        
        if ( ! empty($data) ) {

            foreach ( $data as $d ) {   
                
                $movie = $client->getMoviesApi()->getMovie($d->movie_id, ['language' => 'it']);
                
                $results[] = [
                    'id'                =>  $movie['id'],
                    'title'             =>  $movie['title'],
                    'vote_average'      =>  $movie['vote_average'],
                    'poster_path'       =>  $movie['poster_path'],
                    'popularity'        =>  $movie['popularity'],
                    'original_title'    =>  $movie['original_title'],
                    'overview'          =>  $movie['overview'],
                    'release_date'      =>  $movie['release_date'],
                ];
            }

            $status = TRUE;
        }
       
        $this->response(json($status, 'Lista film', $results));

    }
    
    //-----------------------------------------------------------------------------

    public function create_client() {

        $config = $this->load->config('movies/api',TRUE);

        $token =  new ApiToken($config['api_key']); 

        $ed = new Symfony\Component\EventDispatcher\EventDispatcher();

        $client = new Client(
            [
                'api_token' => $token,
                'event_dispatcher' => [
                    'adapter' => $ed
                ],
                // We make use of PSR-17 and PSR-18 auto discovery to automatically guess these, but preferably set these explicitly.
                'http' => [
                    'client' => null,
                    'request_factory' => null,
                    'response_factory' => null,
                    'stream_factory' => null,
                    'uri_factory' => null,
                ]
            ]
        );

        /**
         * Required event listeners and events to be registered with the PSR-14 Event Dispatcher.
         */
        $requestListener = new RequestListener($client->getHttpClient(), $ed);
        $ed->addListener(RequestEvent::class, $requestListener);

        $apiTokenListener = new ApiTokenRequestListener($client->getToken());
        $ed->addListener(BeforeRequestEvent::class, $apiTokenListener);

        $acceptJsonListener = new AcceptJsonRequestListener();
        $ed->addListener(BeforeRequestEvent::class, $acceptJsonListener);

        $jsonContentTypeListener = new ContentTypeJsonRequestListener();
        $ed->addListener(BeforeRequestEvent::class, $jsonContentTypeListener);

        $userAgentListener = new UserAgentRequestListener();
        $ed->addListener(BeforeRequestEvent::class, $userAgentListener);


        return $client;
    }
    //-----------------------------------------------------------------------------


}