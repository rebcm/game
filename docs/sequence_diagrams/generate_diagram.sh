#!/bin/bash

# Instalar o mermaid-cli se não estiver instalado
npm install -g @mermaid-js/mermaid-cli

# Gerar o diagrama
mmdc -i images/request_flow_sequence_diagram.mmd -o images/request_flow_sequence_diagram.png -t dark -b transparent -H 800 -W 1200
