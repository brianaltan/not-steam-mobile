import 'package:flutter/material.dart';
import 'package:not_steam/widgets/left_drawer.dart';

class ProductEntryFormPage extends StatefulWidget {
  const ProductEntryFormPage({super.key});

  @override
  State<ProductEntryFormPage> createState() => _ProductEntryFormPageState();
}

class _ProductEntryFormPageState extends State<ProductEntryFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _price = 0;
  String _description = "";
  String _videoTrailer = "";
  double _rating = 0.0;
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Tambah Product Kamu',
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                label: "Product Name",
                hint: "Enter product name",
                onChanged: (value) => setState(() => _name = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Product name cannot be empty!";
                  }
                  if (value.length < 3) {
                    return "Product name must be at least 3 characters long!";
                  }
                  if (value.length > 255) {
                    return "Product name cannot exceed 255 characters!";
                  }
                  return null;
                },
              ),
              _buildTextField(
                label: "Price",
                hint: "Enter price",
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() => _price = int.tryParse(value) ?? 0),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Price cannot be empty!";
                  }
                  final price = int.tryParse(value);
                  if (price == null) {
                    return "Price must be a valid number!";
                  }
                  if (price < 0) {
                    return "Price cannot be negative!";
                  }
                  return null;
                },
              ),
              _buildTextField(
                label: "Description",
                hint: "Enter description",
                onChanged: (value) => setState(() => _description = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Description cannot be empty!";
                  }
                  if (value.length > 1000) {
                    return "Description cannot exceed 1000 characters!";
                  }
                  return null;
                },
              ),
              _buildTextField(
                label: "Video Trailer URL",
                hint: "Enter video trailer URL",
                onChanged: (value) => setState(() => _videoTrailer = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Video trailer URL cannot be empty!";
                  }
                  final urlPattern = r'^(http|https):\/\/[^\s$.?#].[^\s]*$';
                  final result = RegExp(urlPattern, caseSensitive: false).hasMatch(value);
                  if (!result) {
                    return "Enter a valid URL!";
                  }
                  return null;
                },
              ),
              _buildTextField(
                label: "Rating",
                hint: "Enter rating",
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() => _rating = double.tryParse(value) ?? 0.0),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Rating cannot be empty!";
                  }
                  final rating = double.tryParse(value);
                  if (rating == null) {
                    return "Rating must be a valid number!";
                  }
                  if (rating < 0 || rating > 5) {
                    return "Rating must be between 0 and 5!";
                  }
                  return null;
                },
              ),
              _buildTextField(
                label: "Quantity",
                hint: "Enter quantity",
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() => _quantity = int.tryParse(value) ?? 0),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Quantity cannot be empty!";
                  }
                  final quantity = int.tryParse(value);
                  if (quantity == null) {
                    return "Quantity must be a valid number!";
                  }
                  if (quantity < 0) {
                    return "Quantity cannot be negative!";
                  }
                  return null;
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Product successfully saved'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Name: $_name'),
                                    Text('Price: $_price'),
                                    Text('Description: $_description'),
                                    Text('Video Trailer: $_videoTrailer'),
                                    Text('Rating: $_rating'),
                                    Text('Quantity: $_quantity'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _formKey.currentState!.reset();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    required Function(String) onChanged,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}