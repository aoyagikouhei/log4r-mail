#coding: utf-8
require "log4r/outputter/outputter"
require "mail"

module Log4r
  class MailOutputter < Log4r::Outputter
    VERSION = "0.0.1"
    attr_accessor :host, :port, :from, :to, :subject, :body, :encoding
    def initialize(_name, hash={})
      super(_name, hash)
      @host = hash[:host] || "localhost"
      @port = hash[:port] || 25
      @from = hash[:from] || ""
      @to = hash[:to] || ""
      @subject = hash[:subject] || ""
      @body = hash[:body] || ""
      @encoding = hash[:encoding] || "UTF-8"
    end
    
    def write(data)
      send_mail(data.is_a?(Hash) ? data : {body: data})
    end
    
    def send_mail(params)
      mail = make_mail(params)
      add_files(mail, params)
      mail.delivery_method :smtp, {
          :enable_starttls_auto => false,
          :address => params[:host] || @host,
          :port => params[:port] || @port,
        }
      mail.deliver
    end
    
    def make_mail(params)
      encoding = params[:encoding] || @encoding
      from = params[:from] || @from
      to = params[:to] || @to
      subject = apply_encoding(encoding, params[:subject] || @subject)
      body = apply_encoding(encoding, params[:body] || @body)
      
      mail = ::Mail.new do
        from from
        to to
        subject subject
        body body
      end
      mail.charset = encoding
      mail
    end
    
    def add_files(mail, params)
      return if !params[:files]
      params[:files].each do |file|
        mail.add_file(file)
      end
    end
    
    def apply_encoding(encoding, content)
      if encoding == "ISO-2022-JP"
        NKF.nkf("-j", content).force_encoding("binary")
      else
        content
      end
    end
  end
end
