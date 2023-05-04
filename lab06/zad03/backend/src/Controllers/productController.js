const asyncHandler = require("express-async-handler");
const { Product } = require("../Models/Products");

const getProducts = asyncHandler(async (req, res) => {
  const { name, price, quantity } = req.query;

  if (name) {
    const products = await Product.find({
      name: { $regex: name, $options: "i" },
    });

    if (products.length === 0) {
      res.status(404).json({ message: "No products found" });
    }

    res.status(200).json(products);
  }

  if (price) {
    const products = await Product.find().where("price").equals(price);
    if (products.length === 0) {
      res.status(404).json({ message: "No products found" });
    }
    res.status(200).json(products);
  }

  if (quantity) {
    const products = await Product.find().where("quantity").equals(quantity);
    if (products.length === 0) {
      res.status(404).json({ message: "No products found" });
    }
    res.status(200).json(products);
  } else {
    const products = await Product.find({}, {_id: 0, "__v": 0});
    if (products.length === 0) {
      res.status(404).json({ message: "No products found" });
    }
    res.status(200).json(products);
  }
});

const createProduct = asyncHandler(async (req, res) => {
  const { name, price, quantity } = req.body;

  if (!name || !price || !quantity) {
    return res.status(400).json({ message: "All fields are required!" });
  }

  const product = new Product({ name, price, quantity });
  await product.save();
  res.status(201).json(product);
});

const updateProduct = asyncHandler(async (req, res) => {
  const { id } = req.params;
  const { name, price, quantity } = req.body;

  const product = await Product.findById(id);

  if (!product) {
    return res.status(400).json({ message: "Product is not in the database" });
  }

  if (name) {
    product.name = name;
  }
  if (price) {
    product.price = price;
  }
  if (quantity) {
    product.quantity = quantity;
  }

  await product.save();
  res.status(200).json(product);
});

const deleteProduct = asyncHandler(async (req, res) => {
  const { id } = req.params;

  const product = await Product.findByIdAndDelete(id);

  if (!product) {
    return res.status(400).json({ message: "Product is not in the database" });
  }

  res.status(200).json(product);
});

module.exports = {
  getProducts,
  createProduct,
  updateProduct,
  deleteProduct,
};
