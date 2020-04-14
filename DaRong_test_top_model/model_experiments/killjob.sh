#!/bin/bash

kill -9 `ps -ef | grep demo | awk '{print $2}'`
