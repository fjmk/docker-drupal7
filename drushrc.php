<?php

/**
 * Useful shell aliases:
 *
 * Drush shell aliases act similar to git aliases.  For best results, define
 * aliases in one of the drushrc file locations between #3 through #6 above.
 * More information on shell aliases can be found via:
 * `drush topic docs-shell-aliases` on the command line.
 *
 * @see https://git.wiki.kernel.org/index.php/Aliases#Advanced
 */
$options['shell-aliases']['pull'] = '!git pull'; // We've all done it.
$options['shell-aliases']['wipe'] = 'cache-clear all';
$options['shell-aliases']['unsuck'] = 'pm-disable -y overlay,dashboard';
$options['shell-aliases']['dup'] = '!docker-compose up -d';
$options['shell-aliases']['dps'] = '!docker-compose ps';
$options['shell-aliases']['dstop'] = '!docker-compose stop';
$options['shell-aliases']['dstart'] = '!docker-compose start';
$options['shell-aliases']['drestart'] = '!docker-compose stop; sleep 1; docker-compose up -d';
$options['shell-aliases']['drm'] = '!docker-compose stop; docker-compose rm -v';
$options['shell-aliases']['dexec'] = '!docker-compose exec web bash';
