class Application

  @@items = []
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    #item = req.params["item"]
    item_name = req.path.split("/items/").last
    if req.path.match(/items/)
      if @@items.detect{|i| i.name==item_name}

        price=find_item(item_name).price
        resp.write(price)
        resp.status=200
      else
        resp.write("Item not found")
        resp.status=400
      end
    else

      resp.write "Route not found"
      resp.status=404
    end
    #resp.write("\ntest results :\n #{item}\n")

    resp.finish
  end
  def find_item(name)
    @@items.find do |i|
      return i if i.name==name
    end
  end
end
