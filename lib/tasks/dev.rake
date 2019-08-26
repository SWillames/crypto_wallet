namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") {%x(rails db:drop)}
         
      show_spinner("Criando BD") {%x(rails db:create)}
      
      show_spinner("Migrando o BD") {%x(rails db:migrate)}

      show_spinner("Populando o BD....") {%x(rails db:seed)}
    else
      puts "Você não está no ambiente de desenvolvimento"
    end
  end

  def show_spinner(msg_start, msg_end = "Concluido")
    spinner = TTY::Spinner.new("[:spinner) #{msg_start}", format: :dots_9)
    spinner.auto_spin
    yield
    spinner.success("#{msg_end}")
  end
  
end
