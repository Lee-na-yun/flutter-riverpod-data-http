package com.example.flutter_server.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.flutter_server.domain.Product;

public interface ProductRepository extends JpaRepository<Product, Integer> {

}
