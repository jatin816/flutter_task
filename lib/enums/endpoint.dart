enum Endpoint {
  products,
}

extension EndpointExtension on Endpoint {
  String value() {
    switch (this) {
      case Endpoint.products:
        return 'products/';
    }
  }
}
