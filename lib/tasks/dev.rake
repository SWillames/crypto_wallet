namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") {%x(rails db:drop)}
         
      show_spinner("Criando BD") {%x(rails db:create)}
      
      show_spinner("Migrando o BD") {%x(rails db:migrate)}

      %x(rails dev:add_coins)
      %x(rails dev:add_mining_types)
    else
      puts "Você não está no ambiente de desenvolvimento"
    end
  end

  desc "Cadastra as Moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando Moedas") do
      coins = [
          { 
            description: "Bitcoin",
            acronym: "BTC",
            url_image: "http://pngimg.com/uploads/bitcoin/bitcoin_PNG47.png"
          },   
          {
            description: "Ethereum",
            acronym: "ETH",
            url_image: "https://d2a4hncphh3gxw.cloudfront.net/image/artwork/40311/89/23/89231ba1d7cd720fb5d00106b33bf9db_40311"
          },
          {
            description: "DASH",
            acronym: "DASH",
            url_image: "https://wiki.trezor.io/images/Dash.png"
          }
        ]

      coins.each do |coin|
        Coin.find_or_create_by!(coin)    
      end
    end  
  end

  desc "Cadastro dos tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando o tipo de mineração...")do
      mining_types = [
        {description: "Proof of Work", acronym: "PoW"},
        {description: "Proof of Stake", acronym: "PoS"},
        {description: "Proof of Capacity", acronym: "PoC"}
      ]
    
      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end  
    end  
  end
  private
  def show_spinner(msg_start, msg_end = "Concluido")
    spinner = TTY::Spinner.new("[:spinner) #{msg_start}", format: :dots_9)
    spinner.auto_spin
    yield
    spinner.success("#{msg_end}")
  end
  
end
