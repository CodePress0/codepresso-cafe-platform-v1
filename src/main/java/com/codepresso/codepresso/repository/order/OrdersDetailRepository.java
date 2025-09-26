package com.codepresso.codepresso.repository.order;

import com.codepresso.codepresso.entity.order.OrdersDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface OrdersDetailRepository extends JpaRepository<OrdersDetail, Long> {
    Optional<OrdersDetail> findById(Long orderDetailId);

//    @Query("select od.product.productName, os.branch.branchName, os.member.id " +
//            "from OrdersDetail od left join fetch od.orders os " +
//            "where od.id = :orderDetailId")
//    OrdersDetail findByOId(@Param("orderDetailId") Long orderDetailId);
}