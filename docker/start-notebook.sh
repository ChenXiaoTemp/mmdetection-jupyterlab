#!/bin/bash
jupyter-lab --ServerApp.token=$HYPC_JUPYTER_LAB_API_TOKEN --allow-root --ServerApp.ip=0.0.0.0 --no-browser --notebook-dir=/app
