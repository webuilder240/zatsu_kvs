module ZatsuKvs
  class Server

    def initialize
      @@inmemory = {}
    end

    def get(key)
      @@inmemory[key]
    end

    def set(key, value)
      @@inmemory[key] = value
    end

    def restore
      xs = []
      Find.find('/tmp') do |f|
        xs << [File::mtime(f), f] if File::file?(f) && File.extname(f) == '.kvs'
      end
      unless xs.empty?
        xs.sort.each do |mtime, file_name|
          @@inmemory = eval(File.read(file_name))
          File.delete(file_name)
          break
        end
      end
    end

    def backup
      self.class.backup
    end

    def reset
      self.class.reset
    end

    def self.backup
      store_backup
    end

    def self.reset
      @@inmemory = {}
    end

    private

    def self.store_backup
      time_stamp = Time.now.to_i
      File.write("/tmp/#{time_stamp}.kvs", @@inmemory)
    end

  end
end
