#include <iostream>
#include <vector>
#include <string>

class MacFactory {
 public:
  virtual ~MacFactory(){};
  virtual std::string UsefulFunctionA() const = 0;
};

class MACButton : public MacFactory {
 public:
  std::string UsefulFunctionA() const override {
    return "Boton de MAC";
  }
};

class MACCheckBox : public MacFactory {
  std::string UsefulFunctionA() const override {
    return "Checkbox de MAC";
  }
};

class WinFactory {
 public:
  virtual ~WinFactory(){};
  virtual std::string Win_Function() const = 0;
  virtual std::string MAC_Function(const MacFactory &collaborator) const = 0;
};

class WinButton : public WinFactory {
 public:
  std::string Win_Function() const override {
    return "Boton de Windows";
  }
  std::string MAC_Function(const MacFactory &collaborator) const override {
    const std::string result = collaborator.UsefulFunctionA();
    return result;
  }
};

class WinCheckBox : public WinFactory {
 public:
  std::string Win_Function() const override {
    return "Checkbox de Windows";
  }
  std::string MAC_Function(const MacFactory &collaborator) const override {
    const std::string result = collaborator.UsefulFunctionA();
    return result;
  }
};

class AbstractFactory {
 public:
  virtual MacFactory *CreateProductA() const = 0;
  virtual WinFactory *CreateProductB() const = 0;
};

class Boton : public AbstractFactory {
 public:
  MacFactory *CreateProductA() const override {
    return new MACButton();
  }
  WinFactory *CreateProductB() const override {
    return new WinButton();
  }
};

class CheckBox : public AbstractFactory {
 public:
  MacFactory *CreateProductA() const override {
    return new MACCheckBox();
  }
  WinFactory *CreateProductB() const override {
    return new WinCheckBox();
  }
};

void ClientCode(const AbstractFactory &factory) {
  const MacFactory *product_a = factory.CreateProductA();
  const WinFactory *product_b = factory.CreateProductB();
  std::cout << product_b->Win_Function() << "\n";
  std::cout << product_b->MAC_Function(*product_a) << "\n";
  delete product_a;
  delete product_b;
}

void Aplication(const AbstractFactory &f, int os){
  const MacFactory *product_a = f.CreateProductA();
  const WinFactory *product_b = f.CreateProductB();
  if (os==1)  std::cout << product_b->Win_Function() << "\n";
  if (os==2)  std::cout << product_b->MAC_Function(*product_a) << "\n";
  delete product_a;
  delete product_b;
}



int main() {
  Boton *f1 = new Boton();
  //CheckBox *f1 = new CheckBox();
  Aplication(*f1,2);
  delete f1;
  return 0;
}
