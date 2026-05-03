# Critérios de aceitação para dicas
def validate_dicas
  # Verificar se as dicas estão aprovadas
  dicas = JSON.parse(File.read('./assets/dicas/dicas.json'))
  dicas['dicas'].each do |dica|
    raise 'Dica não aprovada' unless dica['aprovado'] && dica['aprovado_tecnico']
  end
end
