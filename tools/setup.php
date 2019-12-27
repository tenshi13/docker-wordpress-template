<?php
/**
 *
 * Generates the docker compose env file
 * by prompting the using a few questions
 *
 */
    require('vendor/output.php');

    function isDomainUrl($input) {
        return true;
    }

    $configList = [
        'WP_IMAGE' => ['label'   => 'wordpress image',
                       'default' => 'wordpress:5.0.3-php7.1-apache'
                      ],
        'WP_LOCAL_DOMAIN' => ['label'   => 'wp local domain',
                              'default' => 'test.com'
                             ],
        'WP_DB' => ['label'   => 'wp db name',
                    'default' => 'wordpressdb'
                   ],
        'WP_USER' => ['label'   => 'wp db username',
                      'default' => 'user'
                     ],
        'WP_PASS' => ['label'   => 'wp db password',
                      'default' => 'pass'
                     ]
    ];

    echo "\n";
    Output::Display('Setup docker compose .env file');
    foreach($configList as $key => $data) {
        $input = Output::Prompt("please enter ".$data['label']." (default: ".$data['default'].") : ");
        if($input==='') {
            $input = $data['default'];
        }
        if($key=='WP_LOCAL_DOMAIN') {
            $input = 'dev.'.$input;
            echo "Local development domain set to : ".$input."\n";
        }
        $configList[$key]['value'] = $input;
    }

    // create the config file
    $configs = '';
    foreach($configList as $key => $data) {
        $configs .= $key."=".$data['value']."\n";
    }
    $configFile = __DIR__.DIRECTORY_SEPARATOR.'.env';
    Output::Display("Writting configs to ".$configFile);
    file_put_contents($configFile, $configs);
    Output::Result(true);

    $targetPath = __DIR__.DIRECTORY_SEPARATOR."..".DIRECTORY_SEPARATOR."devops".DIRECTORY_SEPARATOR."docker".DIRECTORY_SEPARATOR.".env";
    Output::Display("Copy config to docker folder : devops/docker/.env");
    copy($configFile, $targetPath);
    Output::Result(true);

