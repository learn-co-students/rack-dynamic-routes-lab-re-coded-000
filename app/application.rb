class Application
  @@items =[Item.new("Apple",2),Item.new("bluberry",5)]
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    if req.path.match(/items/) then
      item_name = req.path.split("/items/").last
      if req_item = @@items.find {|i| i.name == item_name}
        resp.write req_item.price
      else
        resp.status = 400
        resp.write "Item not found"
      end
    else
      resp.status = 404
      resp.write "Route not found"
    end
    resp.finish
  end
end
