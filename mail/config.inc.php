<?php
$config = array();
$config['db_dsnw'] = 'mysql://roundcube:changeme@localhost/roundcube';
/* Auch lokal wird mit TLS gearbeitet (Stichwort: Sniffer) 
Der FQDN sollte "localhost" vorgezogen werden (Zertifikatsvalidierung) */
$config['default_host'] = 'tls://mail.domain.tld';
$config['smtp_server'] = 'tls://mail.domain.tld';
$config['smtp_port'] = 587;
$config['smtp_user'] = '%u';
$config['smtp_pass'] = '%p';
$config['support_url'] = '';
$config['product_name'] = $_SERVER['HTTP_HOST'];
/* Roundcube erhält die Möglichkeit, ACLs und Sieve Filter durch Plugins zu verwalten. */
$config['plugins'] = array(
	'acl',
	'managesieve',
);
$config['login_autocomplete'] = 2;
$config['imap_cache'] = 'apc';
$config['username_domain'] = '%d';
$config['default_list_mode'] = 'threads';
$config['preview_pane'] = true;
/* Da ein selbst-signiertes Zertifikat verwendet wird, gestaltet sich
die Zertifikatsvalidierung weniger restriktiv */
$config['imap_conn_options'] = array(
    'ssl' => array(
      'allow_self_signed' => true,
      'verify_peer'       => false,
      'verify_peer_name'  => false,
    ),
);
$config['smtp_conn_options'] = array(
   'ssl'         => array(
      'allow_self_signed' => true,
      'verify_peer'       => false,
      'verify_peer_name'  => false,
   ),
);
