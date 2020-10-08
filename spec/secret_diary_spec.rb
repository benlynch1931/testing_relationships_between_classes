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


  context "Testing with instance" do
    let (:diary) { double("diary") }

    context "Works when @unlocked" do
      before do
        allow(diary).to receive(:read).and_return("I'm reading this diary!")
        allow(diary).to receive(:write).and_return("I wrote to the diary!")
      end

      it "gets read" do
        subject = SecretDiary.new(diary)
        subject.unlock
        expect(subject.read).to eq("I'm reading this diary!")
      end

      it "gets written" do
        subject = SecretDiary.new(diary)
        subject.unlock
        expect(subject.write("New diary entry")).to eq(nil)
      end
    end

    context "Cannot work when @unlocked = false" do
      before do
        allow(diary).to receive(:read).and_return("I'm reading the diary!")
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
