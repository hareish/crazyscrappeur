require_relative "../lib/dark_tradeur"

describe "Vérifier le nombre de résultats" do
  it "au minimum 10" do
    expect(get_currencies().count).to be > 10
  end
end
