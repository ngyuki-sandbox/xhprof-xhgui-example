<?php
function a()
{
    usleep(100000);
    b();
}

function b()
{
    usleep(200000);
    c();
}

function c()
{
    usleep(300000);
    d();
}

function d()
{
    usleep(400000);
}

a();
