require "spec_helper"
describe Log4r::MailOutputter do
  it "initialize" do
    obj = Log4r::MailOutputter.new("name")
    obj.host.should == "localhost"
    obj.port.should == 25
    obj.from.should == ""
    obj.to.should == ""
    obj.subject.should == ""
    obj.body.should == ""
    obj.encoding.should == "UTF-8"
  end
  
  it "initialize with hash" do
    obj = Log4r::MailOutputter.new("name", {
      host: "192.168.0.1",
      port: 26,
      from: "from@example.com",
      to: "to@example.com",
      subject: "hello",
      body: "world",
      encoding: "ISO-2022-JP",
    })
    obj.host.should == "192.168.0.1"
    obj.port.should == 26
    obj.from.should == "from@example.com"
    obj.to.should == "to@example.com"
    obj.subject.should == "hello"
    obj.body.should == "world"
    obj.encoding.should == "ISO-2022-JP"
  end
  
  it "write" do
    obj = Log4r::MailOutputter.new("name", {
      from: "from@example.com",
      to: "to@example.com",
      subject: "hello",
    })
    proc {
      obj.write("hi")
    }.should raise_error(Errno::ECONNREFUSED, /^Connection refused/)
  end
end
