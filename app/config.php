<?php
    $SOURCE = 'Env Vars';

    if (file_exists(__DIR__ . '/vendor/') && file_exists('/var/www/.env')) {
        require __DIR__ . '/vendor/autoload.php';
        $SOURCE = '.env file';
        $dotenv = Dotenv\Dotenv::createUnsafeImmutable('/var/www'); // Allow access via getenv (no thread-safety issues because environment does not change)
        $dotenv->load();
    }

    $CONFIG = [
        'CONFIG_SOURCE' => $SOURCE,
        'DOPPLER_CONFIG' => getenv('DOPPLER_CONFIG'),
        'DOPPLER_ENVIRONMENT' => getenv('DOPPLER_ENVIRONMENT'),
        'DOPPLER_PROJECT' => getenv('DOPPLER_PROJECT'),        
    ];
?>