#!/usr/bin/env php
<?php

$img = file_get_contents($argv[1] ?? 'grid-bg-24px.png');
$bg = 'data:image/png;base64,' . base64_encode($img);

echo "body.js-selection\n  background: \$background-color url($bg) left top\n";
