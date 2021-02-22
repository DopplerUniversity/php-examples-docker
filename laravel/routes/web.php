<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    $config = [
        'APP_NAME' => env('APP_NAME'),
        'APP_ENV' => env('APP_ENV'),
        'APP_DEBUG' => env('APP_DEBUG'),
        'BROADCAST_DRIVER' => env('BROADCAST_DRIVER'),
        'CACHE_DRIVER' => env('CACHE_DRIVER'),
        'DB_CONNECTION' => env('DB_CONNECTION'),
        'LOG_CHANNEL' => env('LOG_CHANNEL'),
        'DB_CONNECTION' => env('DB_CONNECTION'),
        'LOG_LEVEL' => env('LOG_LEVEL'),
        'MAIL_MAILER' => env('MAIL_MAILER'),
        'MAIL_FROM_ADDRESS' => env('MAIL_FROM_ADDRESS'),
        'MAIL_FROM_NAME' => env('MAIL_FROM_NAME'),
        'QUEUE_CONNECTION' => env('QUEUE_CONNECTION'),
        'SESSION_DRIVER' => env('SESSION_DRIVER'),
        'SESSION_LIFETIME' => env('SESSION_LIFETIME'),
        'DOPPLER_CONFIG' => env('DOPPLER_CONFIG', null),
        'DOPPLER_ENVIRONMENT' => env('DOPPLER_ENVIRONMENT', null),
        'DOPPLER_PROJECT' => env('DOPPLER_PROJECT', null),
    ];

    return view('doppler')->withConfig($config);
});
