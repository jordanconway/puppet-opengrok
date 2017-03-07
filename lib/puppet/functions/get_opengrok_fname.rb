Puppet::Functions.create_function(:get_opengrok_fname) do
  dispatch :get_opengrok_fname do
    param 'String', :opengrok_url
  end

  def get_opengrok_fname(opengrok_url)
    a = opengrok_url.split('/')
    a.last
  end

end
