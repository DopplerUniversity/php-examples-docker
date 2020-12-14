<?php
    $CONFIG = [
        'DEBUG' => getenv('DEBUG'),
        'DOPPLER_CONFIG' => getenv('DOPPLER_CONFIG'),
        'DOPPLER_ENVIRONMENT' => getenv('DOPPLER_ENVIRONMENT'),
        'DOPPLER_PROJECT' => getenv('DOPPLER_PROJECT'),
        'HOSTNAME' => getenv('HOSTNAME'),
        'LOGGING' => getenv('LOGGING'),
        'NODE_ENV' => getenv('NODE_ENV'),
        'PORT' => getenv('PORT'),
        'RATE_LIMITING_ENABLED' => getenv('RATE_LIMITING_ENABLED'),
        'TRANSLATION_SUGGESTION' => getenv('TRANSLATION_SUGGESTION'),
        'YODA_TRANSLATE_API_ENDPOINT' => getenv('YODA_TRANSLATE_API_ENDPOINT'),
        'YODA_TRANSLATE_API_KEY' => getenv('YODA_TRANSLATE_API_KEY'),
    ];
?>