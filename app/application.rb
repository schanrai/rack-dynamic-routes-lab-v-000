class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)


    if req.path.match(/items/)
      item_name = req.path.split("/items/").last #turn /items/Thing into Thing
      item = @@items.find{|i| i.name == item_name}

      resp.write song.artist
    end
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    elsif req.path.match(/add/)
      item_value = req.params["item"]
        if @@items.include? item_value
          @@cart << item_value
          resp.write "added #{item_value}"
        else
          resp.write "We don't have that item!"
        end
    else
      resp.write "Path Not Found"
    end

    resp.finish
end
