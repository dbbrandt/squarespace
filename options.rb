require "slop"

LOGGER = Logger.new(STDOUT)
LOGGER.level = Logger::INFO


# Managed the command line arguments
opts = Slop.parse do |o|
  o.on '--test', 'run with default values' do
    @test = true
  end
  o.on '--debug', 'run in debug mode' do
    LOGGER.level = Logger::INFO
  end
  o.on '-v', '--version', 'print the version' do
    puts '1.0'
  end
  o.on '-f', '--file', 'squaresapce export file (Wordpress Format)' do
    @squarespace_file = opts(:file)
  end

end

if @test
  puts "test mode"
  @squarespace_file = "/Users/dbrandt/Projects/squarespace/Wordpress.xml"
else
  @squarespace_file = opts[:squarespace]
end

LOGGER.info("Debugging on") if LOGGER.level == Logger::DEBUG
LOGGER.info("book_id = #{@book_id}")
LOGGER.info("toc = #{@toc_file}")
LOGGER.info("docbook = #{@docbook_file}")
LOGGER.info("element_id = #{@element_id}") if @element_id
