#!/usr/bin/python3

import os

def hello(event, context):
    print(f'hello {os.environ["NAME"]}')