module SavonTestHelper
  HttpMock = Struct.new(:code, :headers, :body) do
    def error?
      false
    end
  end

  def mock_savon_response(xml_response, code = 200, headers = {})
    http = HttpMock.new(code, headers, xml_response)
    savon_local_options = Savon::LocalOptions.new
    savon_global_options = Savon::GlobalOptions.new
    savon_response = Savon::Response.new(http, savon_global_options, savon_local_options)
  end
end