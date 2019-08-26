# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

spinner = TTY::Spinner.new("[:spinner] Cadastrando moedas...", format: :dots_10)
spinner.auto_spin
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

spinner.success("Concluido!")