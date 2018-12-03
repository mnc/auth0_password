RSpec.describe Auth0Password do
  describe "#excellent" do
    context "when min_length is 10" do
      subject(:password_length) { Auth0Password.new(min_length: 10).excellent(length).length }

      context "with length parameter 12" do
        let(:length) { 12 }

        it { is_expected.to eq(12) }
      end

      context "with length parameter 8" do
        let(:length) { 8 }

        it { is_expected.to eq(10) }
      end
    end

    context "when called 10000 times" do
      let(:passwords) { 10000.times.map{ Auth0Password.new.excellent } }

      it "returns a password which doesn't have more than 2 continuous characters" do
        expect(passwords.none?{ |pw| /(.)\1{2,}/.match(pw) }).to be_truthy
      end
    end
  end

  describe "#good" do
    context "when min_length is 10" do
      subject(:password_length) { Auth0Password.new(min_length: 10).good(length).length }

      context "with length parameter 12" do
        let(:length) { 12 }

        it { is_expected.to eq(12) }
      end

      context "with length parameter 8" do
        let(:length) { 8 }

        it { is_expected.to eq(10) }
      end
    end

    context "when called 10000 times" do
      let(:passwords) { 10000.times.map{ Auth0Password.new.good } }

      it "returns a password which has a lowercase letter, an uppercase letter, and a number" do
        expect(passwords.all?{ |pw| /[a-z]/.match(pw) && /[A-Z]/.match(pw) && /[0-9]/.match(pw) }).to be_truthy
      end
    end
  end

  describe "#fair" do
    context "when strength is fair" do
      subject(:password_length) { Auth0Password.new(min_length: 10).fair(length).length }

      context "with length parameter 12" do
        let(:length) { 12 }

        it { is_expected.to eq(12) }
      end

      context "with length parameter 8" do
        let(:length) { 8 }

        it { is_expected.to eq(10) }
      end
    end
  end

  describe "#low" do
    context "when strength is low" do
      subject(:password_length) { Auth0Password.new(min_length: 10).fair(length).length }

      context "with length parameter 12" do
        let(:length) { 12 }

        it { is_expected.to eq(12) }
      end

      context "with length parameter 8" do
        let(:length) { 8 }

        it { is_expected.to eq(10) }
      end
    end
  end

  describe "#replace_continuous_chars!" do
    context "with password parameter 'AAAA99999bbb%%%'" do
      subject(:has_continuous_chars) { !!/(.)\1{2,}/.match(replaced_password) }
      let(:replaced_password) { Auth0Password.new.send(:replace_continuous_chars!, "AAAA99999bbb%%%") }

      it "replaces more than 2 continuous characters with other characters" do
        is_expected.to be_falsey
      end
    end
  end
end
