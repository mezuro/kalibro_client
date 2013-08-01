module KalibroEntities
  module KalibroCucumberHelpers
    class Configuration
      attr_accessor :database, :user, :password,
                    :query_file_path, :psql_file_path, :kalibro_home,
                    :tomcat_user, :tomcat_group, :tomcat_restart_command

      def initialize(attributes={})
        self.database               = "kalibro_test"
        self.user                   = "kalibro"
        self.password               = "kalibro"
        self.psql_file_path         = "/tmp/PostgreSQL.sql"
        self.query_file_path        = "/tmp/query"
        self.kalibro_home           = "/usr/share/tomcat6/.kalibro"
        self.tomcat_user            = "tomcat6"
        self.tomcat_group           = "tomcat6"
        self.tomcat_restart_command = "sudo\\ service\\ tomcat6\\ restart"

        attributes.each { |field, value| send("#{field}=", value) if respond_to?("#{field}=") }
      end
    end
  end
end