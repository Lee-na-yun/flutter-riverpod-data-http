package com.example.flutter_server;

import java.util.Arrays;
import java.util.List;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.example.flutter_server.domain.Product;
import com.example.flutter_server.repository.ProductRepository;

@Configuration
public class SetupDB {

    @Bean
    public CommandLineRunner run(ProductRepository productRepository) {
        return (args) -> {
            Product p1 = Product.builder().name("바나나").price(500).build();
            Product p2 = Product.builder().name("딸기").price(1000).build();
            Product p3 = Product.builder().name("호박").price(2000).build();
            Product p4 = Product.builder().name("고구마").price(3000).build();
            Product p5 = Product.builder().name("당근").price(4000).build();

            List<Product> productList = Arrays.asList(p1, p2, p3, p4, p5);
            productRepository.saveAll(productList);
        };
    }
}
