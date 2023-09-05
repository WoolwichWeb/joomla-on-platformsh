    /**
     * Inject platform.sh configuration from the environment into Joomla!
     *
     * This is automatically inserted into web/configuration.php by Platform's
     * deploy hook. See: .platform/relationships_fragment.php
     */
    public function __construct() {
        if (empty($_ENV['PLATFORM_RELATIONSHIPS'])) {
            return;	
        }

        $relationships = json_decode(base64_decode($_ENV['PLATFORM_RELATIONSHIPS']), TRUE);
        
        if (!empty($relationships['database']) && !empty($relationships['database'][0])) {
            $this->db = $relationships['database'][0]['path'];
            $this->user = $relationships['database'][0]['username'];
            $this->password = $relationships['database'][0]['password'];
            $this->host = $relationships['database'][0]['host'];
        }
    }
