require_relative '../lib/secret_diary'

### WARNING ###
# For the purposes of this exercise, you are testing after
# the code has been written. This means your tests are prone
# to false positives!
#
# Make sure your tests work by deleting the bodies of the
# methods in `secret_diary.rb`, like this:
#
# ```ruby
# def write(new_message)
# end
# ```
#
# If they fail, then you know your tests are working
# as expected.
### WARNING ###

RSpec.describe SecretDiary do
  context "when locked" do
    let (:diary) { double("diary") }
    let (:secret_diary) { instance_double("SecretDiary") }
    before do
      allow(secret_diary).to receive(:read).and_return("Go away!")
      allow(secret_diary).to receive(:write).and_return("Go away!")
    end
    it "refuses to be read" do
      expect(secret_diary.read).to eq("Go away!")
    end

    it "refuses to be written" do
      expect(secret_diary.write("Message")).to eq("Go away!")
    end
  end

  context "when unlocked" do
    let (:diary) { double("diary") }
    let (:secret_diary) { instance_double("SecretDiary") }
    before do
      allow(secret_diary).to receive(:read).and_return(nil)
      allow(secret_diary).to receive(:write)
    end
    it "gets read" do
      expect(secret_diary.read).to eq nil
    end

    it "gets written" do
      expect(secret_diary.write("Message")).to eq nil
    end
  end

  context "Testing with instance" do
    let (:diary) { double("diary") }

    context "Works when @unlocked" do
      before do
        allow(diary).to receive(:write).and_return("I wrote to the diary!")
        allow(diary).to receive(:read).and_return(diary.write)
      end

      it "gets read" do
        subject = SecretDiary.new(diary)
        subject.unlock
        expect(subject.read).to eq("I wrote to the diary!")
      end
      it "gets written" do
        subject = SecretDiary.new(diary)
        subject.unlock
        # expect(subject.write(nil)).to eq("I wrote to the diary!")
        expect(subject.write(nil)).to eq(nil)
      end
    end

    context "Cannot work when @unlocked = false" do
      before do
        allow(diary).to receive(:read).and_return("I Read the diary!")
        allow(diary).to receive(:write).and_return("I wrote to the diary!")
      end
      it "returns go away!" do
        subject = SecretDiary.new(diary)
        expect(subject.read).to eq "Go away!"
        expect(subject.write(nil)).to eq "Go away!"
      end
    end
  end
end
