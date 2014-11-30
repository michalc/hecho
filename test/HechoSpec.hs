import Main
import Library
import Test.Hspec
 
main :: IO ()
main = hspec $ do
 
  describe "myFunc" $ do
    it "returns 3" $ do
      myFunc 3 `shouldBe` 3