# get_opengrok_fname function
Puppet::Functions.create_function(:get_opengrok_fname) do
  # @param opengrok_url Takes a full download url from https://github.com/OpenGrok/OpenGrok/releases
  # @return [String] Returns a string of just the filename of the download.
  # @example Calling the function
  #   get_opengrok_fname('https://github.com/OpenGrok/OpenGrok/files/467358/opengrok-0.12.1.6.tar.gz.zip')
  dispatch :get_opengrok_fname do
    param 'String', :opengrok_url
  end

  def get_opengrok_fname(opengrok_url)
    a = opengrok_url.split('/')
    a.last
  end

end
